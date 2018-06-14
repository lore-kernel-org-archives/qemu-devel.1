Received: from eggs.gnu.org ([2001:4830:134:3::10]:40323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vskytta@gmail.com>) id 1fTVRW-0007sv-3P
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 12:49:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vskytta@gmail.com>) id 1fTVRV-0007wO-3t
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 12:49:50 -0400
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:36386)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vskytta@gmail.com>) id 1fTVRU-0007vs-VF
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 12:49:49 -0400
Received: by mail-it0-x244.google.com with SMTP id j135-v6so9624286itj.1
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 09:49:48 -0700 (PDT)
MIME-Version: 1.0
Sender: vskytta@gmail.com
In-Reply-To: <d26962f9-7f7d-da39-861e-0e5b5515c703@redhat.com>
References: <20180612065150.21110-1-ville.skytta@iki.fi>
	<d26962f9-7f7d-da39-861e-0e5b5515c703@redhat.com>
From: =?UTF-8?Q?Ville_Skytt=C3=A4?= <ville.skytta@iki.fi>
Date: Thu, 14 Jun 2018 19:49:26 +0300
Message-ID: <CABr9L5B9Hspeq8tBe319Rct5XXFH3_NoxuxoVecSNg+-KXWP8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Tue, Jun 12, 2018 at 3:11 PM, Eric Blake <eblake@redhat.com> wrote:
> On 06/12/2018 01:51 AM, Ville Skytt=C3=A4 wrote:
>>
>> Signed-off-by: Ville Skytt=C3=A4 <ville.skytta@iki.fi>
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> ---
>
>
> It's helpful to use 'git send-email -v3' (or 'git format-patch -v3',
> depending on your workflow) so that the subject line tags this as a third
> spin of the same patch previously posted, and to include, after the ---
> separator, how it differs from v2 (in this case, incorporating my review
> comment to reflow a long line).  Otherwise, automated tools might not pic=
k
> up on the fact that this email replaces your earlier submission as the on=
e
> to test.  Other submission tips can be found at:
>
> https://wiki.qemu.org/Contribute/SubmitAPatch

Ok, will keep that in mind for the future. In the meantime, am I still
expected to do something to this latest patch, or just wait :)?
