Received: from eggs.gnu.org ([2001:4830:134:3::10]:52693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ddgd4-0005k9-54
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 13:43:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ddgd3-00023r-II
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 13:43:18 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:35750)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ddgd3-00022k-AR
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 13:43:17 -0400
Received: by mail-wm0-x22a.google.com with SMTP id m85so25313952wma.0
	for <qemu-devel@nongnu.org>; Fri, 04 Aug 2017 10:43:17 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Aug 2017 18:42:54 +0100
Message-ID: <CAFEAcA-Se9r30gHpYd34vF0Z-yQbDtpOBi8qyqvtTXMja85Zdg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Do we need a "virt-2.10" machine type before the 2.10
 release?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Andrew Jones <drjones@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi; I noticed today that the virt board doesn't have a virt-2.10
machine type defined. Do we need to add it before release?

(I don't know if there have in fact been any changes between
2.9 and 2.10 that would be compatibility issues.)

thanks
-- PMM
