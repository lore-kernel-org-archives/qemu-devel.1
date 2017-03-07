Received: from eggs.gnu.org ([2001:4830:134:3::10]:34811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cl2Yp-0004Cp-4T
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 19:01:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cl2Yo-0002Vt-8V
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 19:01:03 -0500
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <0f0225c6-cf7f-e4dd-a91a-340303dafec7@redhat.com>
References: <1488817322-11397-1-git-send-email-kwolf@redhat.com>
	<1488817322-11397-7-git-send-email-kwolf@redhat.com>
	<0f0225c6-cf7f-e4dd-a91a-340303dafec7@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philippe@mathieu-daude.net>
Date: Mon, 6 Mar 2017 21:00:55 -0300
Message-ID: <CAAdtpL7NtBH=LP-xB4F7KeDH5tSwhFT2=gdpFNv2_4B_OS1Dpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 06/10] block: Factor out
 should_update_child()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, jcody@redhat.com, Fam Zheng <famz@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>

On Mon, Mar 6, 2017 at 5:35 PM, Eric Blake <eblake@redhat.com> wrote:
> On 03/06/2017 10:21 AM, Kevin Wolf wrote:
>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>> ---
>>  block.c | 42 +++++++++++++++++++++++++++---------------
>>  1 file changed, 27 insertions(+), 15 deletions(-)
>>
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

>
> --
> Eric Blake   eblake redhat com    +1-919-301-3266
> Libvirt virtualization library http://libvirt.org
>
