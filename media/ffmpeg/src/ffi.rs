// Copyright 2022 The Chromium OS Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#![allow(non_upper_case_globals)]
#![allow(non_camel_case_types)]
#![allow(non_snake_case)]
#![allow(dead_code)]
#![allow(clippy::approx_constant)]
#![allow(clippy::missing_safety_doc)]
#![allow(clippy::redundant_static_lifetimes)]
#![allow(clippy::too_many_arguments)]
#![allow(clippy::type_complexity)]
#![allow(clippy::upper_case_acronyms)]
// Some of the tests generated by bindgen rely on dereferencing a null pointer
// (https://github.com/rust-lang/rust-bindgen/issues/1651), which is UB. Let's tolerate this to
// avoid a bunch of warnings.
#![allow(deref_nullptr)]

include!("ffmpeg.rs");
