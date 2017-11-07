Received: from eggs.gnu.org ([2001:4830:134:3::10]:50751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eC0qJ-0005vm-3g
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 05:10:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eC0qD-0004ri-9E
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 05:10:51 -0500
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:55246)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eC0qD-0004rI-2x
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 05:10:45 -0500
Received: by mail-wm0-x22e.google.com with SMTP id r68so2578664wmr.3
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 02:10:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171102213907.11443-1-programmingkidx@gmail.com>
References: <20171102213907.11443-1-programmingkidx@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Nov 2017 10:10:23 +0000
Message-ID: <CAFEAcA-1hRpdwU5TV0G1wpUiY3xdwrSzFvZyR6RVYRC+LDcasA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 1/2] ui/cocoa.m: move ungrab to
 ctrl-alt-g
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Arbuckle <programmingkidx@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 2 November 2017 at 21:39, John Arbuckle <programmingkidx@gmail.com> wrote:
> Currently the cocoa user interface relys on the user pushing control-alt to ungrab the mouse. This is patch changes the key combination to control-alt-g to be in line with the GTK user interface.

Hi; I've applied this to cocoa.next.

This commit message needed line-wrapping.
It also looks like you forgot the cover letter
for this patchset.

thanks
-- PMM
