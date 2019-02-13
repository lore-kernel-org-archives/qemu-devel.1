Received: from eggs.gnu.org ([209.51.188.92]:54552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gtqPu-00033A-7H
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 04:01:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gtqPt-0005Mn-3O
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 04:01:17 -0500
Date: Wed, 13 Feb 2019 16:54:58 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190213085458.GB4262@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190130000653.16267-1-richardw.yang@linux.intel.com>
	<20190212052224.GA4839@richard>
	<20190212003414-mutt-send-email-mst@kernel.org>
	<4d6f639b-fe11-7048-3975-ee1c1875b8d3@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d6f639b-fe11-7048-3975-ee1c1875b8d3@vivier.eu>
Subject: Re: [Qemu-devel] [PATCH v3 0/3] Trivial cleanup in hw/acpi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Wei Yang <richardw.yang@linux.intel.com>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org, imammedo@redhat.com, philmd@redhat.com

On Wed, Feb 13, 2019 at 09:49:01AM +0100, Laurent Vivier wrote:
>On 12/02/2019 06:34, Michael S. Tsirkin wrote:
>> On Tue, Feb 12, 2019 at 01:22:24PM +0800, Wei Yang wrote:
>>> On Wed, Jan 30, 2019 at 08:06:50AM +0800, Wei Yang wrote:
>>>> There are several functions/variable which are not used anymore.
>>>>
>>>> This serials just remove those without functional change.
>>>>
>>>> v3: add ack and repost in a new thread
>>>> v2: change commit log from "is now used in no place" to "in not used anymore"
>>>
>>> Michael,
>>>
>>> Looks this serials is not merged yet.
>>>
>>> Is there any problem I need to fix?
>> 
>> Yes pls repost with fixed reviewed-by tags.
>
>Or I can take the series through the trivial branch and update manually
>Philippe's lastname?
>

Thanks :-)

Let's see Michael's opinion.

>Laurent

-- 
Wei Yang
Help you, Help me
