Received: from eggs.gnu.org ([2001:4830:134:3::10]:51878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gHWm3-0001sW-LU
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 12:21:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gHWlz-0003EP-HR
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 12:21:47 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20181029162441.31631-1-sameo@linux.intel.com>
	<874ld4mzlb.fsf@dusky.pond.sub.org>
	<20181030152041.GD5291@caravaggio.home>
Date: Tue, 30 Oct 2018 17:21:15 +0100
In-Reply-To: <20181030152041.GD5291@caravaggio.home> (Samuel Ortiz's message
	of "Tue, 30 Oct 2018 16:20:41 +0100")
Message-ID: <874ld3h0ck.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 00/19] ACPI reorganization for
 hardware-reduced support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Shannon Zhao <zhaoshenglong@huawei.com>

Samuel Ortiz <sameo@linux.intel.com> writes:

> Hi Markus,
>
> On Mon, Oct 29, 2018 at 06:28:48PM +0100, Markus Armbruster wrote:
>> You neglected to cc: maintainers.  I'm doing that for you now.
>> scripts/get_maintainer.pl can help you finding maintainers.
> Sorry about that. I sent a v3 with all maintainers cc'ed.

I don't think that's necessary unless you add more people than I did.
