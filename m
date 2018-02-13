Received: from eggs.gnu.org ([2001:4830:134:3::10]:50590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1elfFW-0004ul-C5
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 13:24:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1elfFV-0003a9-Nv
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 13:24:14 -0500
Received: from mail-ot0-x231.google.com ([2607:f8b0:4003:c0f::231]:39204)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1elfFV-0003Zv-HM
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 13:24:13 -0500
Received: by mail-ot0-x231.google.com with SMTP id f18so18117077otf.6
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 10:24:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180213184729-mutt-send-email-mst@kernel.org>
References: <1518116908-10852-1-git-send-email-mst@redhat.com>
	<CAFEAcA8kvkfoxnQbqZ4Y44uWtbsirCKdmTcnZJzu=ege9YRfTg@mail.gmail.com>
	<20180209190703-mutt-send-email-mst@kernel.org>
	<CAFEAcA_CL6P31EJyzxom1oh6j8LNDD2+OXjJ65hKsB=zBw6tWQ@mail.gmail.com>
	<CAFEAcA_z25p0NrRuH3vJm9mJJzHZXbgct2GwyojuHXKqejc8JA@mail.gmail.com>
	<20180213184729-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Feb 2018 18:23:52 +0000
Message-ID: <CAFEAcA9q0WCWqxmgmUvvMMa91CDbp7HoWoABsROnjkFxB-umkQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/26] virtio, vhost, pci, pc: features,
 fixes and cleanups
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

On 13 February 2018 at 16:52, Michael S. Tsirkin <mst@redhat.com> wrote:
> I've dropped the crypto vhost patches from the pull request for now.
>
> Pushed with the same name - should be fine now.

Applied the fixed version, thanks.

-- PMM
