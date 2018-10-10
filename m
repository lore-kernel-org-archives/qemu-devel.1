Received: from eggs.gnu.org ([2001:4830:134:3::10]:60439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gAJ8I-0000W2-HY
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 14:22:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gAJ8D-0002VP-Bj
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 14:22:54 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:43605)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gAJ8C-0002V3-TK
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 14:22:49 -0400
Received: by mail-pf1-x441.google.com with SMTP id p24-v6so3032887pff.10
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 11:22:48 -0700 (PDT)
Date: Wed, 10 Oct 2018 11:22:46 -0700 (PDT)
In-Reply-To: <CAFEAcA_fmoBRTk0VKEjuu82eb7piCkq588+v7RT7r6f=_4=OVw@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-e2fff6d4-8420-48c5-92d9-cc03e16dfa48@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 0/5] Misc RISC-V patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: Alistair.Francis@wdc.com, alistair23@gmail.com, Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org

On Wed, 10 Oct 2018 11:10:07 PDT (-0700), peter.maydell@linaro.org wrote:
> On 10 October 2018 at 18:49, Palmer Dabbelt <palmer@sifive.com> wrote:
>> we should really
>> get the ball rolling on our big patch backlog.
>
> Yes, please do. Softfreeze is not all that far away and I
> would strongly prefer not to get an enormous sized pull
> request at the last minute. The ideal pattern is that
> code changes come in at a steady rate across the whole
> of the 'open' part of the development cycle.

Ya, sorry, we've been a bit out of it.  If I understand correctly, the soft 
freeze is the 30th?  If so it's really time to get started, and it looks like 
Michael is busy so I'll have to go figure this out.
