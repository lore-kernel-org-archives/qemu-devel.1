Received: from eggs.gnu.org ([2001:4830:134:3::10]:58392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXNHE-0006uG-3m
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 04:27:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXNHC-00088s-IT
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 04:27:28 -0500
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a]:37736)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gXNHC-0007yx-1F
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 04:27:26 -0500
Received: by mail-ot1-x32a.google.com with SMTP id 40so1281672oth.4
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 01:27:15 -0800 (PST)
MIME-Version: 1.0
References: <20181211205346.11118-1-ehabkost@redhat.com>
In-Reply-To: <20181211205346.11118-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Dec 2018 09:27:03 +0000
Message-ID: <CAFEAcA8YjQSZLDS-m2h5fW=4X90fPMYs9k_sKQBsowyOFtS=pg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/4] x86 queue, 2018-12-11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm-devel <kvm@vger.kernel.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>

On Tue, 11 Dec 2018 at 20:53, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> The following changes since commit 32a1a94dd324d33578dca1dc96d7896a0244d768:
>
>   Update version for v3.1.0 release (2018-12-11 17:18:37 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/x86-next-pull-request
>
> for you to fetch changes up to 0e8916582991b9fd0b94850a8444b8b80d0a0955:
>
>   i386: Add "stibp" flag name (2018-12-11 18:50:48 -0200)
>
> ----------------------------------------------------------------
> x86 queue, 2018-12-11
>
> * New CPU features: MOVDIRI, MOVDIR64B (Liu Jingqi);
>   STIBP (Eduardo Habkost)
> * Fix clang build warning (Peter Maydell)
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
