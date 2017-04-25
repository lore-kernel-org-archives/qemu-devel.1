Received: from eggs.gnu.org ([2001:4830:134:3::10]:37078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d31oa-0006up-Hq
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 10:51:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d31oZ-0003wz-Jf
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 10:51:40 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:35605)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d31oZ-0003wf-Bu
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 10:51:39 -0400
Received: by mail-wm0-x234.google.com with SMTP id w64so25164296wma.0
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 07:51:39 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Apr 2017 15:51:17 +0100
Message-ID: <CAFEAcA8xJ11azOh-sQhzpsb0b++EGT+hML-fvvKRSkyOirB1PQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] QEMU travis builds: can we move the preseed tarball to
 qemu.org ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Jeff Cody <jcody@redhat.com>

Hi; a recent travis build failure made me notice that our .travis.yml
config references a preseed tarball from here:
http://people.linaro.org/~alex.bennee/qemu-submodule-git-seed.tar.xz

I think this is a bit less than ideal -- we should really be hosting
this on qemu.org. Can we arrange to move it?

thanks
-- PMM
