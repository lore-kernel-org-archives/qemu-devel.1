Received: from eggs.gnu.org ([2001:4830:134:3::10]:43891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eldXo-0008IP-Eq
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:35:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eldXj-0002ai-Gu
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:35:00 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50190 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eldXj-0002a6-Bt
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:34:55 -0500
Date: Tue, 13 Feb 2018 17:34:52 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180213173452.20fe8f2f@redhat.com>
In-Reply-To: <e8cf7f36-249f-a3cc-f414-fac4e8b56b51@redhat.com>
References: <1516117900-11382-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1516117900-11382-5-git-send-email-stefanb@linux.vnet.ibm.com>
	<1e1dd3a3-7d87-38b1-cab3-5be375787896@linux.vnet.ibm.com>
	<20180212204609.GB30111@morn.lan>
	<b2725975-6823-8919-e937-56d8cb404372@linux.vnet.ibm.com>
	<e8cf7f36-249f-a3cc-f414-fac4e8b56b51@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: Laszlo Ersek <lersek@redhat.com>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, Kevin O'Connor <kevin@koconnor.net>, marcandre.lureau@redhat.com, qemu-devel@nongnu.org, mst@redhat.com

On Tue, 13 Feb 2018 17:16:49 +0100
Laszlo Ersek <lersek@redhat.com> wrote:

[...]
> 
> It's possible that I'll scream for additional hw enlightement under OVMF
> later; so I suggest designing in some kind of feature negotiation up-front.
We can add an extra fwcfg file for that later, when/if it's actually needed.

[...]
