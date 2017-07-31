Received: from eggs.gnu.org ([2001:4830:134:3::10]:46341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dcF4v-0007TQ-Bo
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 14:06:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dcF4q-0000wm-E3
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 14:06:05 -0400
Received: from mail-io0-x22c.google.com ([2607:f8b0:4001:c06::22c]:37039)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dcF4q-0000un-8t
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 14:06:00 -0400
Received: by mail-io0-x22c.google.com with SMTP id c74so114162772iod.4
	for <qemu-devel@nongnu.org>; Mon, 31 Jul 2017 11:05:58 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <c76ef5de-81a5-a98e-d598-161694248788@redhat.com>
Date: Mon, 31 Jul 2017 14:05:51 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <776EE91A-4857-4484-AAC1-3C5D67BA77F7@gmail.com>
References: <374E3394-46D9-4459-AE2E-059F8EEC7406@gmail.com>
	<c76ef5de-81a5-a98e-d598-161694248788@redhat.com>
Subject: Re: [Qemu-devel] Call for testers for various versions of Windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>


> On Jul 31, 2017, at 2:03 PM, John Snow <jsnow@redhat.com> wrote:
>=20
>=20
>=20
> On 07/28/2017 03:45 PM, Programmingkid wrote:
>> I have made a page that keeps track of anyone who wishes to be a =
tester for a particular version of Windows. Here is the page: =
http://wiki.qemu.org/Testing/Windows
>>=20
>=20
> I think for this to be successful, you'd have to define exactly what =
the
> required testing *is*.
>=20
> Are these simple installation smoketests? Installation and boot? How =
big
> is the test matrix? What is considered a pass and what is not? Across
> which machine types and which architectures?
>=20
> etc.
>=20
>> If there is a version of Window you would like to help test in QEMU, =
please contact me with the email address you wish to use and the version =
of Windows you wish to support. Your information will be added to this =
list. With this list someone who makes a patch may need your help =
ensuring the patch is compatible with your supported version of Windows.=20=

>>=20
>> Here are all the versions of Windows I have up so far:
>>=20
>> Windows 3.1
>> Windows NT 3.1
>> Windows NT 3.5
>> Windows 95
>> Windows NT 4.0
>> Windows 98
>> Windows ME
>> Windows 2000
>> Windows XP
>> Windows Vista
>> Windows 7
>> Windows 8
>> Windows 10
>> ReactOS
>>=20
>=20
> There's probably people willing to at least do boot tests for some of
> these, but I doubt there's much interest in doing anything more =
rigorous
> than that.

Ok. I could add something like this:

Testing could include these categories:
- Booting
- Networking
- USB
- IDE/ATA
- Video
- Sound
- Input Devices


Thank you for the input.=
