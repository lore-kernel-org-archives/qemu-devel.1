Received: from eggs.gnu.org ([2001:4830:134:3::10]:33262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ecAbb-0001dG-CZ
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:51:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ecAba-0001TI-Mh
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:51:47 -0500
Received: from mail-oi0-x230.google.com ([2607:f8b0:4003:c06::230]:33302)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ecAba-0001SP-I5
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:51:46 -0500
Received: by mail-oi0-x230.google.com with SMTP id y141so15736751oia.0
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 05:51:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180118020157.25401-1-ehabkost@redhat.com>
References: <20180118020157.25401-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jan 2018 13:51:25 +0000
Message-ID: <CAFEAcA_WdJnYnZUoABB1yWZUO81ag2cMMZRAw106VL_GFM6ZcQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/8] x86 queue, 2018-01-17
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, QEMU Developers <qemu-devel@nongnu.org>

On 18 January 2018 at 02:01, Eduardo Habkost <ehabkost@redhat.com> wrote:
> The following changes since commit 8e5dc9ba49743b46d955ec7dacb04e42ae7ada7c:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20180116' into staging (2018-01-16 17:36:39 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/x86-pull-request
>
> for you to fetch changes up to 6cfbc54e8903a9bcc0346119949162d040c144c1:
>
>   i386: Add EPYC-IBPB CPU model (2018-01-17 23:54:39 -0200)
>
> ----------------------------------------------------------------
> x86 queue, 2018-01-17
>
> Highlight: new CPU models that expose CPU features that guests
> can use to mitigate CVE-2017-5715 (Spectre variant #2).
>

Applied, thanks.

-- PMM
