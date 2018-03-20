Received: from eggs.gnu.org ([2001:4830:134:3::10]:45380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1eyD9o-00012C-G3
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 05:02:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1eyD9e-0006p0-V8
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 05:02:12 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:57418
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1eyD9e-0006n6-MF
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 05:02:02 -0400
References: <1521217393-8162-1-git-send-email-frederic.konrad@adacore.com>
	<53df9c19-ca3f-2f47-c586-d270440fb74a@redhat.com>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <d19409ca-504b-e39d-48e5-078021e7a856@adacore.com>
Date: Tue, 20 Mar 2018 10:01:55 +0100
MIME-Version: 1.0
In-Reply-To: <53df9c19-ca3f-2f47-c586-d270440fb74a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] gdbstub: send a terminaison packet instead
 of crashing gdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com, stefanha@redhat.com

oops sorry for that, I'll resend.

Thanks,
Fred

On 03/19/2018 06:43 PM, Eric Blake wrote:
> On 03/16/2018 11:23 AM, KONRAD Frederic wrote:
>=20
> In the subject: s/terminaison/termination/
>=20
>> Since the commit:
>> commit 4486e89c219c0d1b9bd8dfa0b1dd5b0d51ff2268
>> Author: Stefan Hajnoczi <stefanha@redhat.com>
>> Date:=C2=A0=C2=A0 Wed Mar 7 14:42:05 2018 +0000
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 vl: introduce vm_shutdown()
>>
>> GDB crash when qemu exits (at least on sparc-softmmu):
>=20
> s/crash/crashes/
>=20
