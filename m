Received: from eggs.gnu.org ([2001:4830:134:3::10]:41606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1g0LKK-0001yi-AL
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 02:42:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1g0LKJ-0005bZ-8i
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 02:42:08 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:38170)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1g0LKJ-0005bG-0d
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 02:42:07 -0400
Received: by mail-wm0-x243.google.com with SMTP id t25-v6so4822632wmi.3
	for <qemu-devel@nongnu.org>; Wed, 12 Sep 2018 23:42:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180903043900.28592-1-zhangckid@gmail.com>
	<CAK3tnv+FV_Bq10sUU4_p-ma63rU5_dGgSMNK1WkLN2uNhVLj=A@mail.gmail.com>
	<4bfecce9-8036-4a26-7ad1-9c41831ba8b0@redhat.com>
	<CAK3tnvKwj3mHbYqLJXFcknQibpoWmiXnAUcO+Ap+vqYQkWL5rg@mail.gmail.com>
In-Reply-To: <CAK3tnvKwj3mHbYqLJXFcknQibpoWmiXnAUcO+Ap+vqYQkWL5rg@mail.gmail.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Thu, 13 Sep 2018 14:40:27 +0800
Message-ID: <CAK3tnvKEvr2HwELdA7Q6SGTXPYSea_sVTA8U=-FgYf67pvUHbQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V12 00/19] COLO: integrate colo frame with
 block replication and COLO proxy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, zhang.zhanghailiang@huawei.com, lizhijian@cn.fujitsu.com

On Thu, Sep 13, 2018 at 11:10 AM Zhang Chen <zhangckid@gmail.com> wrote:

>
>
> On Wed, Sep 12, 2018 at 3:50 PM Jason Wang <jasowang@redhat.com> wrote:
>
>>
>>
>> On 2018=E5=B9=B409=E6=9C=8810=E6=97=A5 16:16, Zhang Chen wrote:
>> > Hi All.
>> > Have any comments?
>> > Ping...
>> >
>> > Thanks
>> > Zhang Chen
>>
>> I've queued them with some tweaks on the commit log.
>>
>> Please refer the comment of patch 1 and send me a patch on top for a
>> better comment.
>>
>>
> OK. I got it.
>
> Thanks
> Zhang Chen
>

Hi Jason,

I have sent the new version patch 1.
What do you think about the new comments?

Thanks
Zhang Chen



>
>
>> Thanks
>>
>>
