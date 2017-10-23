Received: from eggs.gnu.org ([2001:4830:134:3::10]:58359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1e6S0i-0001Rr-KU
	for qemu-devel@nongnu.org; Sun, 22 Oct 2017 21:58:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1e6S0f-0001kh-HL
	for qemu-devel@nongnu.org; Sun, 22 Oct 2017 21:58:36 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:21288
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1e6S0f-0001jV-4h
	for qemu-devel@nongnu.org; Sun, 22 Oct 2017 21:58:33 -0400
References: <150872266458.482.9599261292286121536@b58463cdfd5f>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <ca9a9b19-9a75-b5e0-ef3b-3c00a38b59f2@cn.fujitsu.com>
Date: Mon, 23 Oct 2017 09:58:24 +0800
MIME-Version: 1.0
In-Reply-To: <150872266458.482.9599261292286121536@b58463cdfd5f>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4] NUMA: Enable adding NUMA node implicitly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, famz@redhat.com
Cc: thuth@redhat.com, indou.takao@jp.fujitsu.com, ehabkost@redhat.com, mst@redhat.com, izumi.taku@jp.fujitsu.com, david@redhat.com, f4bug@amsat.org, alistair23@gmail.com, imammedo@redhat.com, marcel@redhat.com, pbonzini@redhat.com, rth@twiddle.net, patchew-devel@freelists.org

Hi, Fam

At 10/23/2017 09:37 AM, no-reply@patchew.org wrote:
> Hi,
>
> This series failed build test on s390x host. Please find the details below.
>
> Type: series
> Message-id: 1508722422-3861-1-git-send-email-douly.fnst@cn.fujitsu.com
> Subject: [Qemu-devel] [PATCH v4] NUMA: Enable adding NUMA node implicitly

>   GEN     hw/pci/trace.h
>   GEN     hw/s390x/trace.h
>   GEN     hw/vfio/trace.h
>   GEN     hw/acpi/trace.h
>   GEN     hw/arm/trace.h
>   GEN     hw/alpha/trace.h
> Makefile:30: recipe for target 'git-submodule-update' failed
> make: *** [git-submodule-update] Error 1

It also seems that there are something mistake in our test machines.

Thanks,
	dou.

> make: *** Waiting for unfinished jobs....
> === OUTPUT END ===
>
> Test command exited with code: 2
>
>
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@freelists.org
>
