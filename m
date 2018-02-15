Received: from eggs.gnu.org ([2001:4830:134:3::10]:34451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1emOG7-0000J1-NS
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:27:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1emOG6-0000Z8-Vd
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:27:51 -0500
Received: from mail-ot0-x22f.google.com ([2607:f8b0:4003:c0f::22f]:43461)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1emOG6-0000Yy-QN
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:27:50 -0500
Received: by mail-ot0-x22f.google.com with SMTP id q12so561200otg.10
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 10:27:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180212124008.8960-1-cohuck@redhat.com>
References: <20180212124008.8960-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Feb 2018 18:27:29 +0000
Message-ID: <CAFEAcA_JpeUeWoxyhTzzPAkH-Kc0OwV-r91LP=Mt27z1=icdQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] docs: document our stable process
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 12 February 2018 at 12:40, Cornelia Huck <cohuck@redhat.com> wrote:
> Some pointers on how to get a patch into stable.
>
> [contains some suggestions by mdroth]
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
> RFC/D->v2: added mdroth's suggestions
> ---
>  docs/stable-process.rst | 67 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 docs/stable-process.rst
>

Drive-by bikeshed comment: should this be in docs/devel ?
It's aimed at QEMU developers rather than users...

thanks
-- PMM
