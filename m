Received: from eggs.gnu.org ([2001:4830:134:3::10]:52297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dorVl-0005o1-VJ
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 09:34:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dorUm-00052N-UD
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 09:33:57 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:26005)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dorUm-0004pr-Ob
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 09:32:56 -0400
References: <20170830225225.27925-1-f4bug@amsat.org>
	<20170901151850.GD17184@localhost.localdomain>
	<e5407d61-b21c-8ff5-1051-f75a6221e222@amsat.org>
	<20170901154850.GP7570@localhost.localdomain>
	<e8c0ae1e-e157-35a9-fe71-8eb5b44f8178@amsat.org>
From: Yongbok Kim <yongbok.kim@imgtec.com>
Message-ID: <5d7f7453-1303-7879-5437-73a79f2f0033@imgtec.com>
Date: Mon, 4 Sep 2017 14:32:41 +0100
MIME-Version: 1.0
In-Reply-To: <e8c0ae1e-e157-35a9-fe71-8eb5b44f8178@amsat.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/7] QOMify MIPS cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>



On 01/09/2017 17:09, Philippe Mathieu-Daud=C3=A9 wrote:
> On 09/01/2017 12:48 PM, Eduardo Habkost wrote:
>> On Fri, Sep 01, 2017 at 12:44:42PM -0300, Philippe Mathieu-Daud=C3=A9 =
wrote:
>>> On 09/01/2017 12:18 PM, Eduardo Habkost wrote:
>>>> On Wed, Aug 30, 2017 at 07:52:18PM -0300, Philippe Mathieu-Daud=C3=A9=
 wrote:
>>>>> Hi,
>>>>>
>>>>> This series is based on Igor's "complete cpu QOMification" [1] but
>>>>> only modify
>>>>> the MIPS part. Igor posted an updated series [2], both series shoul=
d
>>>>> apply
>>>>> separately.
>>>>>
>>>>> Igor suggested on IRC this series could enter via the Machine core
>>>>> tree, so
>>>>> I added Eduardo and Marcel.
>>>>
>>>> I would do that only if the MIPS maintainers (CCed) aren't
>>>> willing to merge the series themselves.
>>>
>>> Aurelien told me he looked at the series but isn't comfortable with
>>> reviewing QOM code. Anyway since all patches are reviewed/tested and
>>> this is
>>> MIPS only series it also makes sens to me this enters via their tree.
>>>
>>> Eduardo can you Ack this series from the QOM part to help Aurelien?
>>
>> Absolutely:
>>
>> Acked-by: Eduardo Habkost <ehabkost@redhat.com>
>>
>> I will try to review the QOM code more closely and send
>> Reviewed-by lines too.
>=20
> Thank you!
>=20

I can take the series too. Please carry on reviewing.

Regards,
Yongbok
