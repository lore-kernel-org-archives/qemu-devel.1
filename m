Received: from eggs.gnu.org ([2001:4830:134:3::10]:50596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1eJkoN-0002Ff-J2
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 13:40:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1eJkoM-0005xC-KU
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 13:40:51 -0500
References: <20171128121055.6954-1-den@openvz.org>
	<20171128160805.GE3703@localhost.localdomain>
	<b5cb007b-7a6a-c8a0-b551-2efdc4b0cdac@openvz.org>
	<a92ce6e2-0d7d-8db2-e12f-418b77e8abd4@redhat.com>
	<CAFEAcA8Ak5FNNOSujRARVOL78n4v40W-ZfC4n4Bi6imMPJs_FQ@mail.gmail.com>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <e49af3c9-8a7b-24d1-c4ad-4690185cb9a8@openvz.org>
Date: Tue, 28 Nov 2017 21:40:36 +0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8Ak5FNNOSujRARVOL78n4v40W-ZfC4n4Bi6imMPJs_FQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH for 2.11 0/2] QEMU crashes with CD device
 without media
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-stable <qemu-stable@nongnu.org>

On 11/28/2017 08:28 PM, Peter Maydell wrote:
> On 28 November 2017 at 17:01, John Snow <jsnow@redhat.com> wrote:
>> It's not your fault, it's mine for letting this go for a release. It's
>> just unfortunate timing. I'm looking at (at least) the IDE portion of
>> this and the underlying cause in block-backend today.
> If it's not a regression, and nobody reported it for the whole release
> cycle, we might choose to not fix it in 2.11...
>
> thanks
> -- PMM
may be this is related report
https://patchwork.kernel.org/patch/9779795/

Anyway, I will be fine with any decision.

Den
