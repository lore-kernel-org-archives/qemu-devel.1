Received: from eggs.gnu.org ([209.51.188.92]:51110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1gtudK-0007nc-81
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 08:31:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1gtudF-00061H-Tt
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 08:31:23 -0500
Date: Wed, 13 Feb 2019 13:31:03 +0000
From: Wei Yang <richard.weiyang@gmail.com>
Message-ID: <20190213133103.rrkqryspehgeotly@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20190130000653.16267-1-richardw.yang@linux.intel.com>
	<20190212052224.GA4839@richard>
	<20190212003414-mutt-send-email-mst@kernel.org>
	<4d6f639b-fe11-7048-3975-ee1c1875b8d3@vivier.eu>
	<3d700eed-5637-b05a-63c2-9f73a465bcb5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d700eed-5637-b05a-63c2-9f73a465bcb5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/3] Trivial cleanup in hw/acpi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: Laurent Vivier <laurent@vivier.eu>, "Michael S. Tsirkin" <mst@redhat.com>, Wei Yang <richardw.yang@linux.intel.com>, qemu-trivial@nongnu.org, imammedo@redhat.com, qemu-devel@nongnu.org

On Wed, Feb 13, 2019 at 09:56:38AM +0100, Philippe Mathieu-Daudé wrote:
>Hi Laurent,
>
>On 2/13/19 9:49 AM, Laurent Vivier wrote:
>> On 12/02/2019 06:34, Michael S. Tsirkin wrote:
>>> On Tue, Feb 12, 2019 at 01:22:24PM +0800, Wei Yang wrote:
>>>> On Wed, Jan 30, 2019 at 08:06:50AM +0800, Wei Yang wrote:
>>>>> There are several functions/variable which are not used anymore.
>>>>>
>>>>> This serials just remove those without functional change.
>>>>>
>>>>> v3: add ack and repost in a new thread
>>>>> v2: change commit log from "is now used in no place" to "in not used anymore"
>>>>
>>>> Michael,
>>>>
>>>> Looks this serials is not merged yet.
>>>>
>>>> Is there any problem I need to fix?
>>>
>>> Yes pls repost with fixed reviewed-by tags.
>> 
>> Or I can take the series through the trivial branch and update manually
>> Philippe's lastname?
>
>I appreciate the help with manual update, however Wei is not the only
>one having this problem (other developpers has non-ASCII in their name,
>and use such tags).
>I'd rather prefer we find a proper configuration setup to help the
>community.
>

How you configure your git send-email? or related facility?

>Another (fair) approach is to forbid non-ASCII chars in all part of patches.
>
>Regards,
>
>Phil.

-- 
Wei Yang
Help you, Help me
