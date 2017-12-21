Received: from eggs.gnu.org ([2001:4830:134:3::10]:39357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eS9tz-0000Wv-Hb
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 18:05:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eS9ty-0003X0-RV
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 18:05:23 -0500
Received: from mail-oi0-x231.google.com ([2607:f8b0:4003:c06::231]:34558)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eS9ty-0003WT-Ls
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 18:05:22 -0500
Received: by mail-oi0-x231.google.com with SMTP id u193so17885041oie.1
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 15:05:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171221223704-mutt-send-email-mst@kernel.org>
References: <1513866427-27125-1-git-send-email-mst@redhat.com>
	<CAFEAcA_pt7XhXOhL2jSxwH9ooL7xjShmp6eBAYpRLc=dY-=TXQ@mail.gmail.com>
	<20171221223704-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Dec 2017 23:05:01 +0000
Message-ID: <CAFEAcA8-Pe4gVJcKnGXAwia8Y4FD=3r=E-EZuqcX68UZeLoXLg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/25] pc, pci, virtio: features, fixes,
 cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 21 December 2017 at 20:37, Michael S. Tsirkin <mst@redhat.com> wrote:
> Done and pushed - I dropped the conflicting patch.

Have you also dropped the other one Philippe says depends on it?

thanks
-- PMM
