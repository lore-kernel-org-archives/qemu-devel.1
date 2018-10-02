Received: from eggs.gnu.org ([2001:4830:134:3::10]:40512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7I68-0001xN-9S
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 06:40:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7I65-0008OS-PQ
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 06:40:11 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:38056)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g7I63-0008MT-S7
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 06:40:09 -0400
Received: by mail-oi1-x241.google.com with SMTP id u197-v6so1099212oif.5
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 03:40:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1538069046-5757-1-git-send-email-gengdongjiu@huawei.com>
References: <1538069046-5757-1-git-send-email-gengdongjiu@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Oct 2018 11:39:46 +0100
Message-ID: <CAFEAcA8Ui8-1NGW799jkegK3_XjC18N-LCdJy7-NQe9VGDHDOg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target/arm: fix code comments error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dongjiu Geng <gengdongjiu@huawei.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 27 September 2018 at 18:24, Dongjiu Geng <gengdongjiu@huawei.com> wrote:
> The parameter of kvm_arm_init_cpreg_list() is ARMCPU instead of
> CPUState, so correct the note to make it match the code.
>
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>




Applied to target-arm.next, thanks.

-- PMM
