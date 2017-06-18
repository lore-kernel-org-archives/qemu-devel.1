Received: from eggs.gnu.org ([2001:4830:134:3::10]:56896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dMbSH-0002CA-1N
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 10:45:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dMbSD-0000NT-4q
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 10:45:33 -0400
In-Reply-To: <mailman.79275.1497783014.22739.qemu-devel@nongnu.org>
References: <mailman.79275.1497783014.22739.qemu-devel@nongnu.org>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <AF8C3FA5-35D0-4391-8F3B-C9723FBEE2BE@gmail.com>
Content-Transfer-Encoding: 7bit
From: G 3 <programmingkidx@gmail.com>
Date: Sun, 18 Jun 2017 10:45:25 -0400
Subject: Re: [Qemu-devel] [PATCH v3] target-ppc: Enable open-pic timers to
 count and generate interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alarson@ddci.com
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org list:PowerPC" <qemu-ppc@nongnu.org>


On Jun 18, 2017, at 6:50 AM, qemu-devel-request@nongnu.org wrote:
> On Fri, Jun 16, 2017 at 11:31:02AM -0500, alarson@ddci.com wrote:
>> Aaron Larson <alarson@ddci.com> wrote on 06/05/2017 12:22:53 PM:
>>
>>> From: Aaron Larson <alarson@ddci.com>
>>> To: agraf@suse.de, alarson@ddci.com, david@gibson.dropbear.id.au,
>> qemu-devel@nongnu.org, qemu-ppc@nongnu.org
>>> Date: 06/05/2017 12:22 PM
>>> Subject: [PATCH v3] target-ppc: Enable open-pic timers to count and
>> generate interrupts
>>>
>>> Previously QEMU open-pic implemented the 4 open-pic timers including
>>> all timer registers, but the timers did not "count" or generate any
>>> interrupts.  The patch makes the timers both count and generate
>>> interrupts.  The timer clock frequency is fixed at 25MHZ.
>>
>>
>> I haven't received any feedback on this patch, and I don't see a  
>> response
>> on the mailing list archive.  Did it get lost?

Does QEMU behave differently after this patch is implemented? 
