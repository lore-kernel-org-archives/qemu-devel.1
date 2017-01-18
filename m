Received: from eggs.gnu.org ([2001:4830:134:3::10]:34247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <skiver.cloud.yzy@gmail.com>) id 1cTl0E-00073D-3a
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 02:49:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <skiver.cloud.yzy@gmail.com>) id 1cTl0D-0003ZO-D9
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 02:49:54 -0500
MIME-Version: 1.0
In-Reply-To: <c8fbc6e3-7862-ad33-1344-b21b8118e0fc@redhat.com>
References: <1484709699-3455-1-git-send-email-skiver.cloud.yzy@gmail.com>
	<66ed2121-c207-d2f4-2e05-b6474bfa6a49@redhat.com>
	<CAHkcwacJ_BBOTDBxrDejqNiuzWcfrjVRWM-yNeuRF98tEc+xPw@mail.gmail.com>
	<c8fbc6e3-7862-ad33-1344-b21b8118e0fc@redhat.com>
From: Yang Ziyue <skiver.cloud.yzy@gmail.com>
Date: Wed, 18 Jan 2017 15:49:52 +0800
Message-ID: <CAHkcwacbQXoyqn2y5AL=-LfmO6W7jmET1K8PQy1QfJpiYbxHLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v4 1/2] gdbstub.c: fix GDB connection
 segfault caused by empty machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Ziyue Yang <yzylivezh@hotmail.com>

Got it. Thanks!

2017-01-18 15:48 GMT+08:00 Thomas Huth <thuth@redhat.com>:
>  Hi,
>
> On 18.01.2017 08:43, Yang Ziyue wrote:
>> Hi Thomas,
>>
>> I'm not quite sure about that, but did you mean that I should mention
>> the second patch before the Sign-off line instead of in the commit
>> message?
>
> No, I meant: You still got the sentence "Also some updates from
> fprintf(stderr, ...) to error_report." in the description of your first
> patch. But indeed this is now done in the second patch instead. So
> simply remove that sentence from the description of your first patch,
> and everything is fine :-)
>
>  Thomas
>
