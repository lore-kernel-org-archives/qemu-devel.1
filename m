Received: from eggs.gnu.org ([209.51.188.92]:36795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gonhy-0006of-Ba
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 06:07:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gonhx-0007lI-PW
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 06:07:06 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46724)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gonhx-0007l9-Ju
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 06:07:05 -0500
Received: by mail-wr1-f66.google.com with SMTP id l9so25486845wrt.13
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 03:07:05 -0800 (PST)
References: <20190130000653.16267-1-richardw.yang@linux.intel.com>
	<20190130000653.16267-2-richardw.yang@linux.intel.com>
	<69177d59-02c9-c6cd-be5a-092bf2476af1@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0dcf35c6-1b12-9e20-a0f5-b3fe2ea0ae74@redhat.com>
Date: Wed, 30 Jan 2019 12:07:02 +0100
MIME-Version: 1.0
In-Reply-To: <69177d59-02c9-c6cd-be5a-092bf2476af1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Thomas Huth <thuth@redhat.com>, Wei Yang <richardw.yang@linux.intel.com>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Cc: imammedo@redhat.com, laurent@vivier.eu, mst@redhat.com

On 1/30/19 10:50 AM, Thomas Huth wrote:
> On 2019-01-30 01:06, Wei Yang wrote:
>> Function pc_acpi_init() is not used anymore.
>>
>> Remove the definition and declaration.
>>
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> Reviewed-by: Philippe Mathieu-Daud茅 <philmd@redhat.com>
>> Tested-by: Philippe Mathieu-Daud茅 <philmd@redhat.com>
> 
>  Hi,
> 
> at least in my e-mail client here, it looks like Philippe's last name
> got mojibaked here. It should be "Daudé", not "Daud茅", as far as I know.
> Same thing also happened in patch 2 and 3.

Thanks!

> 
> Apart from that:
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
