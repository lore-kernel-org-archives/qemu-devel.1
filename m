Received: from eggs.gnu.org ([2001:4830:134:3::10]:40383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d6HqU-0005E6-64
	for qemu-devel@nongnu.org; Thu, 04 May 2017 10:35:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d6HqR-0006Yp-1i
	for qemu-devel@nongnu.org; Thu, 04 May 2017 10:35:06 -0400
Date: Thu, 4 May 2017 16:34:53 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170504163453.38c4b98e@nial.brq.redhat.com>
In-Reply-To: <20170504134155.GY3482@thinpad.lan.raisama.net>
References: <1493816238-33120-1-git-send-email-imammedo@redhat.com>
	<20170504134155.GY3482@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 00/24] numa: add '-numa cpu' option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org

On Thu, 4 May 2017 10:41:55 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Wed, May 03, 2017 at 02:56:54PM +0200, Igor Mammedov wrote:
> [...]
> > Igor Mammedov (24):
> >   tests: add CPUs to numa node mapping test
> >   hw/arm/virt: extract mp-affinity calculation in separate function
> >   hw/arm/virt: use machine->possible_cpus for storing possible topology
> >     info
> >   hw/arm/virt: explicitly allocate cpu_index for cpus  
> 
> Patches 1-4 (above) queued on numa-next. Thanks!
> 

Thanks, I'll rebase on top of it and re-post remaining patches.
