Received: from eggs.gnu.org ([2001:4830:134:3::10]:39745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1ec4GN-00018T-N3
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 02:05:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1ec4GJ-0003ME-IH
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 02:05:27 -0500
Received: from mail.weilnetz.de ([37.120.169.71]:39112
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1ec4GJ-0003Le-Bq
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 02:05:23 -0500
References: <1515788548-3570-1-git-send-email-juterry@microsoft.com>
	<1728988755.33187824.1515790085358.JavaMail.zimbra@redhat.com>
	<CY4PR2101MB0866DEFFAF6DB80EBA4CFBF3B6E90@CY4PR2101MB0866.namprd21.prod.outlook.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <893a4f60-4e76-35b7-b776-df0fb73147e6@weilnetz.de>
Date: Thu, 18 Jan 2018 08:05:21 +0100
MIME-Version: 1.0
In-Reply-To: <CY4PR2101MB0866DEFFAF6DB80EBA4CFBF3B6E90@CY4PR2101MB0866.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/4] Implements the Windows Hypervisor
 Platform accelerator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Justin Terry (VM)" <juterry@microsoft.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

Am 18.01.2018 um 00:41 schrieb Justin Terry (VM) via Qemu-devel:
> Hey Paolo,
[...]
> 4. This will be supported on Windows 10 hosts (I don=E2=80=99t have the=
 insider build number yet) and it will require an Intel processor with VT=
-x and Unrestricted Guest support. Will update the qemu-devel list once w=
e have an insider build that is public that has the platform bits.

Is it restricted to professional and enterprise versions of Windows
(that would be bad), or will it run on any Windows 10 host?

Stefan
