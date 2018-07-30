Received: from eggs.gnu.org ([2001:4830:134:3::10]:36407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fk5kG-000163-Ap
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 06:49:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fk5kF-0002i7-ED
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 06:49:44 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:34182)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fk5kF-0002hn-97
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 06:49:43 -0400
Received: by mail-oi0-x241.google.com with SMTP id 13-v6so20363089ois.1
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 03:49:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180730085121.12523-1-pbonzini@redhat.com>
References: <20180730085121.12523-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Jul 2018 11:49:22 +0100
Message-ID: <CAFEAcA97zcO-KSwSZ_8_bLUv4ghT7zhCUkhqc_0KDkK52z70ng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] cryptodev: remove dead code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Gonglei (Arei)" <arei.gonglei@huawei.com>

On 30 July 2018 at 09:51, Paolo Bonzini <pbonzini@redhat.com> wrote:
> Reported by Coverity as CID 1390600.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

This already has a reviewed patch on-list for this from
back in April:

https://patchwork.ozlabs.org/patch/906041/

so I think we should just apply that.

thanks
-- PMM
