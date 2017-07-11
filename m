Received: from eggs.gnu.org ([2001:4830:134:3::10]:48510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dUvKM-00012B-Ch
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:35:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dUvKL-0002VZ-Cu
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:35:46 -0400
References: <149977889860.27.7155414720119907218@5d477a5b5989>
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Message-ID: <38be5548-0b42-59d5-b82a-733b208ced28@virtuozzo.com>
Date: Tue, 11 Jul 2017 16:35:28 +0300
MIME-Version: 1.0
In-Reply-To: <149977889860.27.7155414720119907218@5d477a5b5989>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 0/4] Add shrink image for qcow2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, mreitz@redhat.com, den@openvz.org

On 11.07.2017 16:14, no-reply@patchew.org wrote:
> Hi,
> 
> This series failed build test on s390x host. Please find the details below.
> 
> Type: series
> Subject: [Qemu-devel] [PATCH v4 0/4] Add shrink image for qcow2
> Message-id: 20170711124024.1396-1-pbutsykin@virtuozzo.com
> 

Because this series is rebased on the pending "Implement a
warning_report function" patch-set.

Can I exclude this check? (If I know in advance that the test will fail
by the rebase reason)
