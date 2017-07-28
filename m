Received: from eggs.gnu.org ([2001:4830:134:3::10]:53040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1dazjn-00032F-0s
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 03:31:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1dazji-0005cb-Lr
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 03:31:07 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:37833)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dmitry@daynix.com>) id 1dazji-0005bp-GL
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 03:31:02 -0400
Received: by mail-wm0-x243.google.com with SMTP id t138so7476758wmt.4
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 00:31:02 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (1.0)
From: Dmitry Fleytman <dmitry@daynix.com>
In-Reply-To: <a4a9c830-1047-c0f1-918d-d1543c881cd6@redhat.com>
Date: Fri, 28 Jul 2017 10:30:58 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <86F48478-C3BA-4002-BE6E-7448BB49826F@daynix.com>
References: <20170728053610.15770-1-f4bug@amsat.org>
	<20170728053610.15770-16-f4bug@amsat.org>
	<a4a9c830-1047-c0f1-918d-d1543c881cd6@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 15/47] MAINTAINERS: add missing VMWare
 entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org



> On 28 Jul 2017, at 10:08, Thomas Huth <thuth@redhat.com> wrote:
>=20
>> On 28.07.2017 07:35, Philippe Mathieu-Daud=C3=A9 wrote:
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>>=20
>> RFC because I'm not sure about tests/
>=20
> I think that should be fine, we've got a couple of such entries already
> in the MAINTAINERS file.
>=20
>> MAINTAINERS | 1 +
>> 1 file changed, 1 insertion(+)
>>=20
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index d8aef164ca..9670a3901a 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1140,6 +1140,7 @@ M: Dmitry Fleytman <dmitry@daynix.com>
>> S: Maintained
>> F: hw/net/vmxnet*
>> F: hw/scsi/vmw_pvscsi*
>> +F: tests/vmxnet3-test.c
>>=20
>=20
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Dmitry Fleytman <dmitry@daynix.com>
