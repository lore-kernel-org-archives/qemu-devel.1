Received: from eggs.gnu.org ([2001:4830:134:3::10]:50707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eldy4-0007wM-75
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:02:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eldy1-00031X-MQ
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:02:08 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56530 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1eldy1-000315-Hk
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:02:05 -0500
References: <1516117900-11382-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1516117900-11382-5-git-send-email-stefanb@linux.vnet.ibm.com>
	<1e1dd3a3-7d87-38b1-cab3-5be375787896@linux.vnet.ibm.com>
	<20180212204609.GB30111@morn.lan>
	<b2725975-6823-8919-e937-56d8cb404372@linux.vnet.ibm.com>
	<e8cf7f36-249f-a3cc-f414-fac4e8b56b51@redhat.com>
	<20180213173452.20fe8f2f@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <0d108314-0915-50b5-255e-ece22c7dfaf0@redhat.com>
Date: Tue, 13 Feb 2018 18:01:50 +0100
MIME-Version: 1.0
In-Reply-To: <20180213173452.20fe8f2f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 4/4] acpi: build TPM Physical Presence
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, Kevin O'Connor <kevin@koconnor.net>, marcandre.lureau@redhat.com, qemu-devel@nongnu.org, mst@redhat.com

On 02/13/18 17:34, Igor Mammedov wrote:
> On Tue, 13 Feb 2018 17:16:49 +0100
> Laszlo Ersek <lersek@redhat.com> wrote:
> 
> [...]
>>
>> It's possible that I'll scream for additional hw enlightement under OVMF
>> later; so I suggest designing in some kind of feature negotiation up-front.
> We can add an extra fwcfg file for that later, when/if it's actually needed.

Works for me.

Thanks
Laszlo
