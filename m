Received: from eggs.gnu.org ([209.51.188.92]:41104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h0lwH-0008PJ-7i
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 06:39:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h0lwG-0001Vw-9M
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 06:39:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34634)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1h0lwF-0001VL-W1
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 06:39:20 -0500
References: <1551695576-13205-1-git-send-email-thuth@redhat.com>
	<a0b53ff0-1ded-2a6e-aa4d-b1f4fcc407c1@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <73da2fd2-dca4-495f-6824-8abb62c3e045@redhat.com>
Date: Mon, 4 Mar 2019 12:39:13 +0100
MIME-Version: 1.0
In-Reply-To: <a0b53ff0-1ded-2a6e-aa4d-b1f4fcc407c1@redhat.com>
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
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Ed Maste <emaste@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 04/03/2019 12.08, Philippe Mathieu-Daud=C3=A9 wrote:
> On 3/4/19 11:32 AM, Thomas Huth wrote:
>> cirrus-ci.com also has the possibility to run CI tasks on macOS.
>> Since most of the QEMU developers do not have access to macOS yet,
>> let's add a CI pipeline for this operating system here, too.
>=20
> Can we get report of failures? (IRC, mail to ML, patchew icon)

Honestly, I've got no clue ... this is the only help text that I've
found so far:

 https://cirrus-ci.org/guide/notifications/

  Thomas
