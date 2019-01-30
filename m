Received: from eggs.gnu.org ([209.51.188.92]:57607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gov7I-0004LR-Dh
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 14:01:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gov7G-0001kd-EE
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 14:01:44 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531]:43782)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gov7C-0001gX-PW
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 14:01:40 -0500
Received: by mail-pg1-x531.google.com with SMTP id v28so209019pgk.10
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 11:01:31 -0800 (PST)
Date: Wed, 30 Jan 2019 11:01:29 -0800 (PST)
In-Reply-To: <b9b988df-140e-108d-a80d-48c7ce1b351d@redhat.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-a324878c-b61d-4d8d-80bf-e15404469ef7@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PR RFC] RISC-V Patches for 3.2, Part 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eblake@redhat.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org

On Wed, 30 Jan 2019 09:45:33 PST (-0800), eblake@redhat.com wrote:
> On 1/30/19 11:35 AM, Palmer Dabbelt wrote:
>> The following changes since commit 5385a5988c8a55bebdc878c05b96648579b5d6e0:
>>
>>   hw/virtio/virtio-balloon: zero-initialize the virtio_balloon_config struct (2019-01-21 17:20:36 +0000)
>>
>> are available in the Git repository at:
>>
>>   git://github.com/palmer-dabbelt/qemu.git tags/riscv-for-master-3.2-part3
>>
>> for you to fetch changes up to 461ab9de46d085a37b0da6f096aadc4e0dda4d4c:
>>
>>   target/riscv: fix counter-enable checks in ctr() (2019-01-29 11:33:38 -0800)
>>
>> ----------------------------------------------------------------
>> RISC-V Patches for 3.2, Part 3
>
> There is no 3.2 release; the next release is named 4.0.  However, if you
> don't want to bother with sending a v2 pull request just to fix the
> merge commit message, that's okay with me.

Ah, sorry.  I think I'm just going to leave it as is, I'll get it right next 
time.
