Received: from eggs.gnu.org ([209.51.188.92]:60421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h1zee-00045K-Sq
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 15:30:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h1zee-0005hb-8D
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 15:30:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1h1zed-0005gm-VS
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 15:30:12 -0500
References: <1551695576-13205-1-git-send-email-thuth@redhat.com>
	<a0b53ff0-1ded-2a6e-aa4d-b1f4fcc407c1@redhat.com>
	<CAPyFy2AnxWBXjUOWRy7_YpoSFadQBAXRooM+t4g6t6XOaF1XgA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <84cc4186-86a8-2152-11ab-bd4001b05ee7@redhat.com>
Date: Thu, 7 Mar 2019 21:30:06 +0100
MIME-Version: 1.0
In-Reply-To: <CAPyFy2AnxWBXjUOWRy7_YpoSFadQBAXRooM+t4g6t6XOaF1XgA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] cirrus.yml: Add macOS continuous
 integration task
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ed Maste <emaste@freebsd.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Li-Wen Hsu <lwhsu@freebsd.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 07/03/2019 21.26, Ed Maste wrote:
> On Mon, 4 Mar 2019 at 07:11, Philippe Mathieu-Daud=C3=A9 <philmd@redhat=
.com> wrote:
>>
>> On 3/4/19 11:32 AM, Thomas Huth wrote:
>>> cirrus-ci.com also has the possibility to run CI tasks on macOS.
>>> Since most of the QEMU developers do not have access to macOS yet,
>>> let's add a CI pipeline for this operating system here, too.
>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Acked-by: Ed Maste <emaste@freebsd.org>

Thanks! I can take this patch through my qtest tree.

 Thomas
