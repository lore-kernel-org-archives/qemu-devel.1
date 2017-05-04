Received: from eggs.gnu.org ([2001:4830:134:3::10]:60832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d6HTL-0000F0-60
	for qemu-devel@nongnu.org; Thu, 04 May 2017 10:11:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d6HTG-00045Q-KT
	for qemu-devel@nongnu.org; Thu, 04 May 2017 10:11:11 -0400
Date: Thu, 4 May 2017 10:41:55 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170504134155.GY3482@thinpad.lan.raisama.net>
References: <1493816238-33120-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1493816238-33120-1-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 00/24] numa: add '-numa cpu' option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org

On Wed, May 03, 2017 at 02:56:54PM +0200, Igor Mammedov wrote:
[...]
> Igor Mammedov (24):
>   tests: add CPUs to numa node mapping test
>   hw/arm/virt: extract mp-affinity calculation in separate function
>   hw/arm/virt: use machine->possible_cpus for storing possible topology
>     info
>   hw/arm/virt: explicitly allocate cpu_index for cpus

Patches 1-4 (above) queued on numa-next. Thanks!

-- 
Eduardo
