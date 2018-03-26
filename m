Received: from eggs.gnu.org ([2001:4830:134:3::10]:40838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0Szi-00052e-2g
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 10:21:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0Szf-00024X-Dd
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 10:21:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34852 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f0Szf-00022I-9Q
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 10:21:03 -0400
References: <1522047629-27658-1-git-send-email-jasowang@redhat.com>
	<1522047629-27658-3-git-send-email-jasowang@redhat.com>
	<34b37cfb-2a0a-e9af-e504-4ff962ec1987@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <98df32f2-c47e-73bd-a3d0-083e4c7edbb4@redhat.com>
Date: Mon, 26 Mar 2018 09:20:54 -0500
MIME-Version: 1.0
In-Reply-To: <34b37cfb-2a0a-e9af-e504-4ff962ec1987@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 2/2] net/vde: print error on vde_open()
 failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Julia Suvorova <jusual@mail.ru>, patchew-devel@freelists.org

On 03/26/2018 07:13 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Jason,
>=20
> On 03/26/2018 04:00 AM, Jason Wang wrote:
>> From: Julia Suvorova via Qemu-devel <qemu-devel@nongnu.org>
>=20
> This doesn't look right, shouldn't it be Julia Suvorova <jusual@mail.ru=
>?

Can patchew be taught to flag mails like this?  (The rewrite occurs when=20
a sender's mail service is so strict that mailman has to rewrite the=20
From: address to get it to the list without the mail being dropped to=20
certain recipients; the sender can work around the problem by manually=20
including a From: line in the body of the message that overrides the=20
overwritten From: line from the headers).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
