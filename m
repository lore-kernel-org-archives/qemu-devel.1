Received: from eggs.gnu.org ([2001:4830:134:3::10]:42544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fJDXO-0004BE-Um
	for qemu-devel@nongnu.org; Thu, 17 May 2018 03:41:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fJDXL-0005lh-SF
	for qemu-devel@nongnu.org; Thu, 17 May 2018 03:41:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50010 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fJDXL-0005la-Nx
	for qemu-devel@nongnu.org; Thu, 17 May 2018 03:41:19 -0400
From: Laszlo Ersek <lersek@redhat.com>
References: <20180515123007.10164-1-marcandre.lureau@redhat.com>
	<229d0059-2ab4-bf2d-cbf5-9dca4ff978bd@redhat.com>
Message-ID: <8ccc6f4a-f52f-e364-1c0f-e480e31483a5@redhat.com>
Date: Thu, 17 May 2018 09:41:13 +0200
MIME-Version: 1.0
In-Reply-To: <229d0059-2ab4-bf2d-cbf5-9dca4ff978bd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [edk2] [PATCH 0/4] RFC: ovmf: Add support for TPM
 Physical Presence interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcandre.lureau@redhat.com, edk2-devel@lists.01.org
Cc: pjones@redhat.com, jiewen.yao@intel.com, qemu-devel@nongnu.org, javierm@redhat.com

On 05/16/18 11:29, Laszlo Ersek wrote:
> Hi Marc-Andr=C3=A9,
>=20
> On 05/15/18 14:30, marcandre.lureau@redhat.com wrote:
>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>
>> Hi,
>>
>> The following series adds basic TPM PPI 1.3 support for OVMF-on-QEMU
>> with TPM2 (I haven't tested TPM1, for lack of interest).

Here's another general request: please make sure that all code you add
(new lines in existent files, and especially brand new files) use CRLF
line terminators.

Thanks!
Laszlo
