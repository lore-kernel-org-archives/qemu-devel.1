Received: from eggs.gnu.org ([2001:4830:134:3::10]:34467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cKP2e-0007y8-Th
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 07:33:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cKP2e-0000Ru-4N
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 07:33:44 -0500
Received: from mail-vk0-x230.google.com ([2607:f8b0:400c:c05::230]:36622)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cKP2d-0000Rm-Vb
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 07:33:44 -0500
Received: by mail-vk0-x230.google.com with SMTP id p9so176891441vkd.3
	for <qemu-devel@nongnu.org>; Fri, 23 Dec 2016 04:33:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5c86185e-a0bb-504e-c8eb-94e07530ed2e@redhat.com>
References: <20161222152300.32395-1-pbonzini@redhat.com>
	<CAFEAcA_EyA1WycYOoqZP767GiufX=DV59v4Hgb=dhk+NoE3X5w@mail.gmail.com>
	<5c86185e-a0bb-504e-c8eb-94e07530ed2e@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Dec 2016 12:33:22 +0000
Message-ID: <CAFEAcA-ROWXbYt6KQocOUJbF=yv0AgNgnT4c5juhtbE8QASLRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/25] First round of misc patches for QEMU
 2.9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 23 December 2016 at 12:12, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 23/12/2016 12:15, Peter Maydell wrote:
>> Applied, thanks. (Nice to see that git is smart enough to
>> be able to merge this on top of the earlier target-* rename.)
>
> Actually I did the rebase myself.

Oops, so you did; I was confused, clearly.

-- PMM
