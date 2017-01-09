Received: from eggs.gnu.org ([2001:4830:134:3::10]:35120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cQdkm-0003iA-4w
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 12:29:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cQdkl-0007i2-By
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 12:29:04 -0500
Received: from mail-ua0-x231.google.com ([2607:f8b0:400c:c08::231]:35229)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cQdkk-0007hu-Uc
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 12:29:03 -0500
Received: by mail-ua0-x231.google.com with SMTP id y9so137185983uae.2
	for <qemu-devel@nongnu.org>; Mon, 09 Jan 2017 09:29:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170109184252-mutt-send-email-mst@kernel.org>
References: <1481922841-4324-1-git-send-email-mst@redhat.com>
	<148192392306.37.10111381964118487672@790289a7ca88>
	<20170109184252-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Jan 2017 17:28:41 +0000
Message-ID: <CAFEAcA-Puj_RJCnyAsGp7gTQZW2+3PECjf8zOiym0gVyfGWB0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL for-2.9 0/9] virtio, vhost, pc: fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 9 January 2017 at 16:48, Michael S. Tsirkin <mst@redhat.com> wrote:
> The strange thing here is that this actually seems to apply patches
> from list instead of getting the tag from the tree.

That's because it's really supposed to be working on patches sent
to the list -- it only checks pull requests because it can't
tell them apart from patches, I think.

thanks
-- PMM
