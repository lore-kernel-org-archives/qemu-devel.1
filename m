Received: from eggs.gnu.org ([2001:4830:134:3::10]:58646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fOoJL-0002Sd-6H
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 13:58:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fOoJI-0003Mx-13
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 13:57:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34356 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fOoJH-0003MH-Tq
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 13:57:55 -0400
References: <20180601171521.1770-1-pbonzini@redhat.com>
	<20180601171521.1770-4-pbonzini@redhat.com>
	<d0ee9736-399a-ce20-5f69-1cf36f29090a@amsat.org>
	<0d714788-b03f-0028-ed14-7fb344d4ff43@redhat.com>
	<3225b86a-f208-4142-1c45-8252e551290e@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8cb86034-ba20-f183-b7bd-d90e614cc502@redhat.com>
Date: Fri, 1 Jun 2018 12:57:54 -0500
MIME-Version: 1.0
In-Reply-To: <3225b86a-f208-4142-1c45-8252e551290e@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 56/56] hw: make virtio devices configurable
 via default-configs/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org

On 06/01/2018 12:36 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 06/01/2018 02:31 PM, Paolo Bonzini wrote:
>> On 01/06/2018 19:26, Philippe Mathieu-Daud=C3=A9 wrote:
>>> On 06/01/2018 02:15 PM, Paolo Bonzini wrote:
>>>> This is only half of the work, because the proxy devices (virtio-*-p=
ci,
>>>> virtio-*-ccw, etc.) are still included unconditionally.  It is still=
 a
>>>> move in the right direction.
>>>>
>>>> Based-on: <20180522194943.24871-1-pbonzini@redhat.com>
>>>
>>> Is this tag useful?
>>
>> Yeah, usually it would go in the cover letter.  It remained here becau=
se
>> this patch was not part of a series.
>=20
> Sorry I meant "is this useful [in the git history, since this is a pull
> request]".

which further implies that sticking it after a --- line would have been=20
appropriate (useful for the list, not so useful for git).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
