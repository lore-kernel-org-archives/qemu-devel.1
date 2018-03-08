Received: from eggs.gnu.org ([2001:4830:134:3::10]:56917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1etuq0-0001pC-SU
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 07:40:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1etupw-0006hz-0m
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 07:40:00 -0500
Received: from mail-wr0-f172.google.com ([209.85.128.172]:33270)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1etupv-0006ha-Pq
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 07:39:55 -0500
Received: by mail-wr0-f172.google.com with SMTP id v18so5536678wrv.0
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 04:39:55 -0800 (PST)
References: <1520365586-30384-1-git-send-email-mjc@sifive.com>
	<20180308122549.GO4718@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7c847e0a-a592-fa29-4712-ffe6f089c6e9@redhat.com>
Date: Thu, 8 Mar 2018 13:39:48 +0100
MIME-Version: 1.0
In-Reply-To: <20180308122549.GO4718@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL] RISC-V QEMU Port Submission v8.2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Michael Clark <mjc@sifive.com>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On 08/03/2018 13:25, Daniel P. Berrangé wrote:
> So I think you likely just need to create a v8.3 branch and
> tag with the correct set of 23 commits. Though, do note Paolo's
> comment about logic looking wrong in one of the patches. I'm
> not sure if that's something we can live with now, and fix
> up in followup patches before release or not, vs should be
> fixed right away.
> 

Luckily the logic is wrong in one of the extra 22 commits.

Paolo
