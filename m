Received: from eggs.gnu.org ([209.51.188.92]:59281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1gopSB-0000Kn-IO
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 07:58:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1gopSA-0005ul-NP
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 07:58:55 -0500
Date: Wed, 30 Jan 2019 12:58:20 +0000
From: Wei Yang <richard.weiyang@gmail.com>
Message-ID: <20190130125820.n7py34wx2oojsaex@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20190130000653.16267-1-richardw.yang@linux.intel.com>
	<20190130000653.16267-2-richardw.yang@linux.intel.com>
	<69177d59-02c9-c6cd-be5a-092bf2476af1@redhat.com>
	<0dcf35c6-1b12-9e20-a0f5-b3fe2ea0ae74@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0dcf35c6-1b12-9e20-a0f5-b3fe2ea0ae74@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/3] hw/i386/pc.c: remove unused
 function pc_acpi_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Wei Yang <richardw.yang@linux.intel.com>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org, imammedo@redhat.com, laurent@vivier.eu, mst@redhat.com

On Wed, Jan 30, 2019 at 12:07:02PM +0100, Philippe Mathieu-Daudé wrote:
>On 1/30/19 10:50 AM, Thomas Huth wrote:
>> On 2019-01-30 01:06, Wei Yang wrote:
>>> Function pc_acpi_init() is not used anymore.
>>>
>>> Remove the definition and declaration.
>>>
>>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>>> Reviewed-by: Philippe Mathieu-Daud茅 <philmd@redhat.com>
>>> Tested-by: Philippe Mathieu-Daud茅 <philmd@redhat.com>
>> 
>>  Hi,
>> 
>> at least in my e-mail client here, it looks like Philippe's last name
>> got mojibaked here. It should be "Daudé", not "Daud茅", as far as I know.
>> Same thing also happened in patch 2 and 3.
>
>Thanks!
>

Opps, sorry for that.

Not sure which part changes the encoding.

>> 
>> Apart from that:
>> 
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> 

-- 
Wei Yang
Help you, Help me
