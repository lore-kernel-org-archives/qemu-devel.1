Received: from eggs.gnu.org ([2001:4830:134:3::10]:39362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fV1yR-0003Me-2z
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 17:46:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fV1yO-0001LS-Q7
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 17:46:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55116 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fV1yO-0001LD-Lt
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 17:46:04 -0400
References: <20180612065150.21110-1-ville.skytta@iki.fi>
	<d26962f9-7f7d-da39-861e-0e5b5515c703@redhat.com>
	<CABr9L5B9Hspeq8tBe319Rct5XXFH3_NoxuxoVecSNg+-KXWP8g@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <21aaf5e7-a25c-0d07-1638-2537cb5360ce@redhat.com>
Date: Mon, 18 Jun 2018 16:46:02 -0500
MIME-Version: 1.0
In-Reply-To: <CABr9L5B9Hspeq8tBe319Rct5XXFH3_NoxuxoVecSNg+-KXWP8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] docs: Grammar and spelling fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Ville_Skytt=c3=a4?= <ville.skytta@iki.fi>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 06/14/2018 11:49 AM, Ville Skytt=C3=A4 wrote:
> On Tue, Jun 12, 2018 at 3:11 PM, Eric Blake <eblake@redhat.com> wrote:
>> On 06/12/2018 01:51 AM, Ville Skytt=C3=A4 wrote:
>>>
>>> Signed-off-by: Ville Skytt=C3=A4 <ville.skytta@iki.fi>
>>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>> ---
>>
>>
>> It's helpful to use 'git send-email -v3' (or 'git format-patch -v3',
>> depending on your workflow) so that the subject line tags this as a th=
ird
>> spin of the same patch previously posted, and to include, after the --=
-
>> separator, how it differs from v2 (in this case, incorporating my revi=
ew
>> comment to reflow a long line).  Otherwise, automated tools might not =
pick
>> up on the fact that this email replaces your earlier submission as the=
 one
>> to test.  Other submission tips can be found at:
>>
>> https://wiki.qemu.org/Contribute/SubmitAPatch
>=20
> Ok, will keep that in mind for the future. In the meantime, am I still
> expected to do something to this latest patch, or just wait :)?

At this point, waiting is probably fine. If no one else responds after a=20
week (such as a maintainer confirming they have queued it), then=20
replying with a ping would be reasonable.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
