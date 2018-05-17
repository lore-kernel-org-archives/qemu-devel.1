Received: from eggs.gnu.org ([2001:4830:134:3::10]:46207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJFrR-0005gP-H5
	for qemu-devel@nongnu.org; Thu, 17 May 2018 06:10:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJFrQ-0008Nm-IK
	for qemu-devel@nongnu.org; Thu, 17 May 2018 06:10:13 -0400
Received: from mail-ot0-x22d.google.com ([2607:f8b0:4003:c0f::22d]:33211)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fJFrQ-0008M5-E4
	for qemu-devel@nongnu.org; Thu, 17 May 2018 06:10:12 -0400
Received: by mail-ot0-x22d.google.com with SMTP id l22-v6so4412892otj.0
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 03:10:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180515215436.6457-1-ehabkost@redhat.com>
References: <20180515215436.6457-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 May 2018 11:09:51 +0100
Message-ID: <CAFEAcA8=+s3eGycOiYPmujwwxrKQr3w5sgFfhgFhM88O5hheBQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/7] x86 queue, 2018-05-15
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

On 15 May 2018 at 22:54, Eduardo Habkost <ehabkost@redhat.com> wrote:
> The following changes since commit ad1b4ec39caa5b3f17cbd8160283a03a3dcfe2ae:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/input-20180515-pull-request' into staging (2018-05-15 12:50:06 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/x86-next-pull-request
>
> for you to fetch changes up to ab8f992e3e63e91be257e4e343d386dae7be4bcb:
>
>   i386: Add new property to control cache info (2018-05-15 11:33:33 -0300)
>
> ----------------------------------------------------------------
> x86 queue, 2018-05-15
>
> * KnightsMill CPU model
> * CLDEMOTE(Demote Cache Line) cpu feature
> * pc-i440fx-2.13 and pc-q35-2.13 machine-types
> * Add model-specific cache information to EPYC CPU model
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
