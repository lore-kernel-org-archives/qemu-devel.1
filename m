Received: from eggs.gnu.org ([209.51.188.92]:51852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gtqFX-00021O-4M
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 03:50:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gtqES-0005DD-Bp
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 03:49:31 -0500
References: <20190130000653.16267-1-richardw.yang@linux.intel.com>
	<20190212052224.GA4839@richard>
	<20190212003414-mutt-send-email-mst@kernel.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <4d6f639b-fe11-7048-3975-ee1c1875b8d3@vivier.eu>
Date: Wed, 13 Feb 2019 09:49:01 +0100
MIME-Version: 1.0
In-Reply-To: <20190212003414-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/3] Trivial cleanup in hw/acpi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Wei Yang <richardw.yang@linux.intel.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, imammedo@redhat.com, philmd@redhat.com

On 12/02/2019 06:34, Michael S. Tsirkin wrote:
> On Tue, Feb 12, 2019 at 01:22:24PM +0800, Wei Yang wrote:
>> On Wed, Jan 30, 2019 at 08:06:50AM +0800, Wei Yang wrote:
>>> There are several functions/variable which are not used anymore.
>>>
>>> This serials just remove those without functional change.
>>>
>>> v3: add ack and repost in a new thread
>>> v2: change commit log from "is now used in no place" to "in not used anymore"
>>
>> Michael,
>>
>> Looks this serials is not merged yet.
>>
>> Is there any problem I need to fix?
> 
> Yes pls repost with fixed reviewed-by tags.

Or I can take the series through the trivial branch and update manually
Philippe's lastname?

Laurent
