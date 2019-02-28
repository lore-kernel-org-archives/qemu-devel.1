Received: from eggs.gnu.org ([209.51.188.92]:37721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gzPhK-0002nL-VN
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 12:42:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gzPhB-0007tN-92
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 12:42:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54020)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gzPh2-0007ne-C5
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 12:42:00 -0500
References: <1551356875-30676-1-git-send-email-thuth@redhat.com>
	<1551356875-30676-10-git-send-email-thuth@redhat.com>
	<eab2ac82-2b97-c7e6-cced-0141aac16cf6@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <307634bc-7f59-ef81-f6ba-8a075da58682@redhat.com>
Date: Thu, 28 Feb 2019 18:41:48 +0100
MIME-Version: 1.0
In-Reply-To: <eab2ac82-2b97-c7e6-cced-0141aac16cf6@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 09/13] MAINTAINERS: Add maintainer to the
 TCG/i386 subsystem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>

On 28/02/2019 17.28, Richard Henderson wrote:
> On 2/28/19 4:27 AM, Thomas Huth wrote:
>> From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>
>> Richard obviously maintains this subdirectory, make this official :)
>>
>> Remove the qemu-devel@nongnu.org entry because the list is always
>> selected by the 'All patches CC here' section.
>>
>> Cc: Richard Henderson <rth@twiddle.net>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  MAINTAINERS | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> s/rth@twiddle.net/richard.henderson@linaro.org/
>=20
> I do this as part of my day job.  With that,
>=20
> Acked-by: Richard Henderson <richard.henderson@linaro.org>

Ok ... shall I resend the PULL request or could you maybe send a
follow-up patch later?

 Thomas
