Received: from eggs.gnu.org ([2001:4830:134:3::10]:49935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ddcao-0008Nf-I2
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 09:29:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ddcZi-0005kq-VQ
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 09:24:40 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:38823)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ddcZi-0005jQ-Ij
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 09:23:34 -0400
Received: by mail-wm0-x22d.google.com with SMTP id m85so19888311wma.1
	for <qemu-devel@nongnu.org>; Fri, 04 Aug 2017 06:23:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170803175937.22225-1-ehabkost@redhat.com>
References: <20170803175937.22225-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Aug 2017 14:23:12 +0100
Message-ID: <CAFEAcA-EDCYW_gq8YcOXfOZJ73=e5dQ8i9ZScK09thPaucQdCA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] cpu: crash fix for -rc2 (don't allow
 negative core id)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On 3 August 2017 at 18:59, Eduardo Habkost <ehabkost@redhat.com> wrote:
> The following changes since commit aaaec6acad7cf97372d48c1b09126a09697519c8:
>
>   Update version for v2.10.0-rc1 release (2017-08-02 16:36:32 +0100)
>
> are available in the git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/machine-pull-request
>
> for you to fetch changes up to be2960baae07e5257cde8c814cbd91647e235147:
>
>   cpu: don't allow negative core id (2017-08-02 18:30:13 -0300)
>
> ----------------------------------------------------------------
> cpu: crash fix (don't allow negative core id)
>
> ----------------------------------------------------------------
>
> Laurent Vivier (1):
>   cpu: don't allow negative core id
>
>  hw/cpu/core.c | 5 +++++
>  1 file changed, 5 insertions(+)

Applied, thanks.

-- PMM
