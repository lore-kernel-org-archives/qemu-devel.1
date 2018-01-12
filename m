Received: from eggs.gnu.org ([2001:4830:134:3::10]:54518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZwpZ-000121-3b
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 05:45:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZwpY-0004NJ-Dr
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 05:45:01 -0500
Received: from mail-ot0-x22e.google.com ([2607:f8b0:4003:c0f::22e]:46177)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eZwpY-0004Mi-8a
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 05:45:00 -0500
Received: by mail-ot0-x22e.google.com with SMTP id f6so4690980oti.13
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 02:45:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180111230524-mutt-send-email-mst@kernel.org>
References: <1513866427-27125-1-git-send-email-mst@redhat.com>
	<CAFEAcA_pt7XhXOhL2jSxwH9ooL7xjShmp6eBAYpRLc=dY-=TXQ@mail.gmail.com>
	<20171221223704-mutt-send-email-mst@kernel.org>
	<CAAdtpL74ZyVsLwgBjpbsdSHbWdY_Uq6ouRAvgo00UdVevTKq8A@mail.gmail.com>
	<20171222014258-mutt-send-email-mst@kernel.org>
	<CAFEAcA8eKTEh3zSOPNm1WgUujNOU+zcNSgBAE5G68QcObQd8sA@mail.gmail.com>
	<20180109060920-mutt-send-email-mst@kernel.org>
	<CAFEAcA_Xhm45N5U8aWZv=geVQMShv13FOEodS7HvPTz3fa9-+A@mail.gmail.com>
	<20180111230524-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jan 2018 10:44:39 +0000
Message-ID: <CAFEAcA-UvuuJmz-7ppuvnmEz2ZpOBnyfVUoufrsURN4TF9vkTw@mail.gmail.com>
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philippe@mathieu-daude.net>, QEMU Developers <qemu-devel@nongnu.org>

On 11 January 2018 at 21:05, Michael S. Tsirkin <mst@redhat.com> wrote:
> Merged and pushed. Pls merge, but please also make sure
> I didn't modify any submodules by mistake.


Applied, thanks. Submodule stuff all ok (my apply-pullreq
script checks these days that there aren't any submodule
changes in by mistake).

-- PMM
