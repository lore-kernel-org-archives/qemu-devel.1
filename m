Received: from eggs.gnu.org ([2001:4830:134:3::10]:37403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jidong.xiao@gmail.com>) id 1f2uxl-0002rz-NW
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 04:37:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jidong.xiao@gmail.com>) id 1f2uxk-0000jl-G0
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 04:37:13 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:39190)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jidong.xiao@gmail.com>)
	id 1f2uxk-0000hq-7q
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 04:37:12 -0400
Received: by mail-wr0-x22b.google.com with SMTP id c24so12741450wrc.6
	for <qemu-devel@nongnu.org>; Mon, 02 Apr 2018 01:37:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180402082442.GA29205@lemon.usersys.redhat.com>
References: <CAG4AFWYeyxHVsFsZHgqrL2+k=-6KtAvmXzK_0HdHU2H4E1fSYA@mail.gmail.com>
	<20180402082442.GA29205@lemon.usersys.redhat.com>
From: Jidong Xiao <jidong.xiao@gmail.com>
Date: Mon, 2 Apr 2018 02:37:10 -0600
Message-ID: <CAG4AFWbn3gv=AYfRgcLbF8B8SXiHncsWzX9LrENp590Q9ZOsXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] qemu testing image link not work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Mon, Apr 2, 2018 at 2:24 AM, Fam Zheng <famz@redhat.com> wrote:
> On Mon, 04/02 01:52, Jidong Xiao wrote:
>> Hi,
>>
>> A huge amount of documents has referenced this testing image:
>>
>> http://wiki.qemu.org/download/linux-0.2.img.bz2
>>
>> However, the image is no longer there. Is the image still available
>> somewhere? Thanks.
>
> According to the edit history of https://wiki.qemu.org/System_Images these
> images are no longer provided by qemu.org. So we should fix the documents. Where
> are they?
>
> Fam


When I was saying documents, I meant all kinds of online documents,
whenever people talk about qemu test images, they refer to the above
link. For example, that link was included in the native kvm tool
readme file.

Whatever, I just found one available mirror:

http://lassauge.free.fr/qemu/release/

At least, we can download those testing images here.

-Jidong
