Received: from eggs.gnu.org ([2001:4830:134:3::10]:53866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e5lQs-0003sZ-Aa
	for qemu-devel@nongnu.org; Sat, 21 Oct 2017 00:30:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e5lQr-00088p-BZ
	for qemu-devel@nongnu.org; Sat, 21 Oct 2017 00:30:46 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <150855120694.473.13335991458621172469@b58463cdfd5f>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d32486cc-434a-d6f6-4b1b-b023ad2f4f06@amsat.org>
Date: Sat, 21 Oct 2017 01:30:34 -0300
MIME-Version: 1.0
In-Reply-To: <150855120694.473.13335991458621172469@b58463cdfd5f>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] Update Paul Burton's email
 address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, paul.burton@mips.com
Cc: famz@redhat.com, paul.burton@imgtec.com, qemu-trivial@nongnu.org, mjt@tls.msk.ru, laurent@vivier.eu, yongbok.kim@imgtec.com, yongbok.kim@mips.com

On 10/20/2017 11:00 PM, no-reply@patchew.org wrote:
> 
> This series failed build test on s390x host. Please find the details below.
> 
> Message-id: 20171020232114.5475-1-paul.burton@mips.com
> Subject: [Qemu-devel] [PATCH] Update Paul Burton's email address
[...]
> === OUTPUT BEGIN ===
[...]
>   CC      mips64-softmmu/memory.o
>   CC      mips64-softmmu/memory_mapping.o
>   CC      mips64el-softmmu/dump.o
> /var/tmp/patchew-tester-tmp-rj_bg3a1/src/rules.mak:66: recipe for target 'memory_mapping.o' failed
> make[1]: *** [memory_mapping.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
>   CC      microblaze-softmmu/accel/tcg/cpu-exec-common.o
> /var/tmp/patchew-tester-tmp-rj_bg3a1/src/rules.mak:66: recipe for target 'accel/tcg/cpu-exec-common.o' failed
> make[1]: *** [accel/tcg/cpu-exec-common.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
>   CC      mips64el-softmmu/migration/ram.o
>   CC      mips64el-softmmu/accel/accel.o
> /var/tmp/patchew-tester-tmp-rj_bg3a1/src/rules.mak:66: recipe for target 'dump.o' failed
> make[1]: *** [dump.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
> /var/tmp/patchew-tester-tmp-rj_bg3a1/src/rules.mak:66: recipe for target 'memory.o' failed
> make[1]: *** [memory.o] Error 1
> Makefile:374: recipe for target 'subdir-mips64-softmmu' failed
> make: *** [subdir-mips64-softmmu] Error 2
> Makefile:374: recipe for target 'subdir-mips64el-softmmu' failed
> make: *** [subdir-mips64el-softmmu] Error 2

Your patch broke the MIPS build !#@$ :D :D :D :P

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
