Received: from eggs.gnu.org ([2001:4830:134:3::10]:53433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1csaGP-0001Jl-Ul
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 15:25:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1csaGM-00078h-LM
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 15:25:13 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:36572)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1csaGM-00077m-Df
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 15:25:10 -0400
Received: by mail-wr0-x229.google.com with SMTP id w11so56527708wrc.3
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 12:25:10 -0700 (PDT)
References: <20170322172621.26186.61813.malonedeb@gac.canonical.com>
	<20170327185204.3388.63632.malone@chaenomeles.canonical.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170327185204.3388.63632.malone@chaenomeles.canonical.com>
Date: Mon, 27 Mar 2017 20:25:07 +0100
Message-ID: <87zig64j58.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Bug 1675108] Re: Cocoa UI always crashes on
 startup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1675108 <1675108@bugs.launchpad.net>
Cc: qemu-devel@nongnu.org


Brendan Shanks <brendan@bslabs.net> writes:

> I just did a quick test on 10.12.3 with those two patches and didn't get
> any crashes

Awesome. I'm rolling the series now. I assume will pickup the patches in
due course.

--
Alex Bennée
