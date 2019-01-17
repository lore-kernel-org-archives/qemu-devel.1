Received: from eggs.gnu.org ([209.51.188.92]:46049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gk3zt-0000PJ-Ju
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 04:30:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gk3zs-0001aj-Hk
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 04:30:01 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:50863)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gk3zs-0001aF-6C
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 04:30:00 -0500
Received: by mail-wm1-x32f.google.com with SMTP id n190so286402wmd.0
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 01:29:59 -0800 (PST)
MIME-Version: 1.0
References: <CAObpvQ=1dw4pTX3aiDvOvgnAkZQ0d9svMaL4Bwz55nkE8i4yrQ@mail.gmail.com>
	<945511ac-d99a-d483-12a2-e6ad4dda09c2@linaro.org>
	<CAObpvQktCHp-9V40z7kDaTU2CwRWSq8ZVS1PxRg3WK01TFXCzQ@mail.gmail.com>
In-Reply-To: <CAObpvQktCHp-9V40z7kDaTU2CwRWSq8ZVS1PxRg3WK01TFXCzQ@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 17 Jan 2019 09:29:46 +0000
Message-ID: <CAJSP0QXAz3W=qi96EL6vCn187j0QUtjGLKwVk5wWTST40h+JMg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] AVX support for TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Nick Renieris <makren67@gmail.com>, qemu-devel <qemu-devel@nongnu.org>

On Wed, Dec 26, 2018 at 1:29 AM Nick Renieris <makren67@gmail.com> wrote:
> Do you think this could work as a GSoC project? I'm potentially
> interested in working on it this summer.

Richard and Nick,
You are welcome to create a GSoC project idea and post it here:
https://wiki.qemu.org/Google_Summer_of_Code_2019

Good project ideas have the following characteristics:
 * Well-defined - the scope is clear
 * Self-contained - there are few dependencies
 * Uncontroversial - they are acceptable to the community
 * Incremental - they produce deliverables along the way

Can you break down the project into tasks?
1. Test cases for SSE and AVX
2. SSE refactoring that needs to be done first
3. AVX instructions that will be covered
4. Stretch goals (AVX2, AVX512, etc)

The project idea template looks like this:

=== TITLE ===

 '''Summary:''' Short description of the project

 Detailed description of the project.

 '''Links:'''
 * Wiki links to relevant material
 * External links to mailing lists or web sites

 '''Details:'''
 * Skill level: beginner or intermediate or advanced
 * Language: C
 * Mentor: Email address and IRC nick
 * Suggested by: Person who suggested the idea


Note that project ideas are open to all applicants in order to ensure fairness.

Stefan
