Received: from eggs.gnu.org ([2001:4830:134:3::10]:34083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cTkzJ-0006bO-CY
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 02:48:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cTkzG-0002zO-9u
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 02:48:57 -0500
References: <1484709699-3455-1-git-send-email-skiver.cloud.yzy@gmail.com>
	<66ed2121-c207-d2f4-2e05-b6474bfa6a49@redhat.com>
	<CAHkcwacJ_BBOTDBxrDejqNiuzWcfrjVRWM-yNeuRF98tEc+xPw@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c8fbc6e3-7862-ad33-1344-b21b8118e0fc@redhat.com>
Date: Wed, 18 Jan 2017 08:48:49 +0100
MIME-Version: 1.0
In-Reply-To: <CAHkcwacJ_BBOTDBxrDejqNiuzWcfrjVRWM-yNeuRF98tEc+xPw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
To: Yang Ziyue <skiver.cloud.yzy@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Ziyue Yang <yzylivezh@hotmail.com>

 Hi,

On 18.01.2017 08:43, Yang Ziyue wrote:
> Hi Thomas,
> 
> I'm not quite sure about that, but did you mean that I should mention
> the second patch before the Sign-off line instead of in the commit
> message?

No, I meant: You still got the sentence "Also some updates from
fprintf(stderr, ...) to error_report." in the description of your first
patch. But indeed this is now done in the second patch instead. So
simply remove that sentence from the description of your first patch,
and everything is fine :-)

 Thomas
