Received: from eggs.gnu.org ([2001:4830:134:3::10]:47780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dp3sQ-00025n-5D
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 22:46:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dp3sL-0005sj-KV
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 22:46:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42050)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dp3sL-0005sE-Dw
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 22:46:05 -0400
References: <20170903163726.16541-1-n54@gmx.com>
	<20170904072353.GA19748@lemon.lan>
	<17D7366F-5413-4A0B-B984-33ED480A9A3C@daynix.com>
	<8c58f1f4-28e2-59e8-e8e6-fa09d546dbca@gmx.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <1b66ecda-fbe2-91de-6b7e-a6c2d407a421@redhat.com>
Date: Tue, 5 Sep 2017 10:45:56 +0800
MIME-Version: 1.0
In-Reply-To: <8c58f1f4-28e2-59e8-e8e6-fa09d546dbca@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] e1000: Rename the SEC symbol to SEQEC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>, Dmitry Fleytman <dmitry@daynix.com>, Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Jonathan Perkin <jperkin@joyent.com>



On 2017=E5=B9=B409=E6=9C=8805=E6=97=A5 07:51, Kamil Rytarowski wrote:
> Please put it on a pull-request queue. I don't maintain one myself.
>
> On 04.09.2017 09:29, Dmitry Fleytman wrote:
>> Reviewed-by: Dmitry Fleytman <dmitry@daynix.com>
>>
>>> On 4 Sep 2017, at 10:23 AM, Fam Zheng <famz@redhat.com> wrote:
>>>
>>> On Sun, 09/03 18:37, Kamil Rytarowski wrote:
>>>> SunOS defines SEC in <sys/time.h> as 1 (commonly used time symbols).
>>>>
>>>> This fixes build on SmartOS (Joyent).
>>>>
>>>> Patch cherry-picked from pkgsrc by jperkin (Joyent).
>>>>
>>>> Signed-off-by: Kamil Rytarowski <n54@gmx.com>
>>> Cc Jason Wang (net maintainer).
>>>
>>> Fam

Applied, will be in next pull request.

Thanks
